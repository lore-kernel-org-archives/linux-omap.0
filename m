From: "andrzej zaborowski" <balrog@zabor.org>
Subject: TSC2102 driver
Date: Fri, 18 Aug 2006 11:56:58 +0200
Message-ID: <fb249edb0608180256t2800b0c7s727ff7ef94266641@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,
I have a driver for the TSC2102 processor that is quite simple but
supports, to my knowledge, all parts controlled by this chip. The next
4 patches contain the parts of the driver. Despite the name of the
chip it's quite different from TSC2101 and needs a separate driver in
my opinion. Also the driver is quite different:

 - It is asynchronous and uses the SPI framework for communication and
thus is not OMAP specific except the ALSA audio driver which also uses
McBSP and would need a separate driver on different arch's.

 - It shares the chip's ADC time between touchscreen data conversion
and data from the sensors.

 - Since the chip controls devices from different categories (audio,
sensors, touchscreen input) I decided to split it in parts:
  * A core TSC2102 SPI driver that communicates with the chip and
presents a C api to other drivers. It works kind of like a bus in the
sense that the probe function first checks if the chip is present, and
only then registers "platform_devices" for the other devices cotrolled
by the chip. This also ensures that the order of suspending/resuming
is correct.
  * An input driver using the Linux touchscreen API.
  * A driver that reports the data from sensors using the hwmon
framework. It can also register an APM callback for reporting power
status if board file requests that.
  * An OMAP audio driver using the existing omap-alsa and
omap-alsa-dma code. It includes a mixer.

I'm using this driver on Palm Tungsten E and I don't know of any other
board that has this chip. Nevertheless it would be nice to have it
merged into linux-omap-2.6, it would save us from rediffing against
new versions. (provided there aren't any awfull mistakes in the code)

This is an example config for a board file (pardon the formatting):

static struct omap_mcbsp_reg_cfg palmte_mcbsp1_regs = {
        .spcr2  = FRST | GRST | XRST | XINTM(3),
        .xcr2   = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
                        XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(1) | XFIG,
        .xcr1   = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
        .srgr2  = GSYNC | CLKSP | FSGM | FPER(31),
        .srgr1  = FWID(15),
        .pcr0   = CLKRM | SCLKME | FSXP | FSRP | CLKXP | CLKRP,
};

static struct omap_alsa_codec_config palmte_alsa_config = {
        .name                   = "TSC2102 audio",
        .mcbsp_regs_alsa        = &palmte_mcbsp1_regs,
        .codec_configure_dev    = NULL, /* tsc2102_configure, */
        .codec_set_samplerate   = NULL, /* tsc2102_set_samplerate, */
        .codec_clock_setup      = NULL, /* tsc2102_clock_setup, */
        .codec_clock_on         = NULL, /* tsc2102_clock_on, */
        .codec_clock_off        = NULL, /* tsc2102_clock_off, */
        .get_default_samplerate = NULL, /* tsc2102_get_default_samplerate, */
};

#ifdef CONFIG_APM
/*
 * The values used here are currently quite inaccurate but enough
 * to give a basic idea of how much longer can the system run and
 * trigger potential alerts.
 */
static void palmte_get_power_status(struct apm_power_info *info, int *battery)
{
        info->battery_flag = 0;

        if (!omap_get_gpio_datain(PALMTE_DC_GPIO)) {
                info->ac_line_status = APM_AC_ONLINE;
                info->battery_status = APM_BATTERY_STATUS_CHARGING;
                info->battery_flag |= APM_BATTERY_FLAG_CHARGING;
        } else {
                info->ac_line_status = APM_AC_OFFLINE;
                if (battery[0] > 2100)
                        info->battery_status = APM_BATTERY_STATUS_HIGH;
                else if (battery[0] > 1900)
                        info->battery_status = APM_BATTERY_STATUS_LOW;
                else
                        info->battery_status = APM_BATTERY_STATUS_CRITICAL;
        }

        if (battery[0] > 2100)
                info->battery_flag |= APM_BATTERY_FLAG_HIGH;
        else if (battery[0] > 1900)
                info->battery_flag |= APM_BATTERY_FLAG_LOW;
        else
                info->battery_flag |= APM_BATTERY_FLAG_CRITICAL;

        if (battery[0] > 2100)
                info->battery_life = 60 + (battery[0] - 2100) * 40 / 80;
        else if (battery[0] > 2000)
                info->battery_life = 30 + (battery[0] - 2000) * 30 / 100;
        else if (battery[0] > 1900)
                info->battery_life = 15 + (battery[0] - 1900) * 15 / 100;
        else
                info->battery_life = (battery[0] - 1620) * 15 / 280;
        if (info->battery_life > 100)
                info->battery_life = 100;

        info->time = 240 * info->battery_life / 100;    /* Four hours */
        info->units = APM_UNITS_MINS;
}
#else
#define palmte_get_power_status NULL
#endif

static struct tsc2102_config palmte_tsc2102_config = {
        .use_internal   = 0,      /* External reference voltage */
        .monitor        = TSC_BAT1 | TSC_AUX | TSC_TEMP,
        .temp_at25c     = { 2200, 2615 },
        .apm_report     = palmte_get_power_status,
        .alsa_config    = &palmte_alsa_config,
};

static struct spi_board_info palmte_spi_board_info[] __initdata = {
        [0]             = {
                .modalias       = "tsc2102",
                .bus_num        = 2,    /* uWire (officially) */
                .chip_select    = 0,    /* As opposed to 3 */
                .irq            = OMAP_GPIO_IRQ(PALMTE_PINTDAV_GPIO),
                .platform_data  = &palmte_tsc2102_config,
                .max_speed_hz   = 8000000,
        },
};

Regards,
Andrzej
-- 
balrog 2oo6
