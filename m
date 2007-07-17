From: "arun c" <arun.edarath@gmail.com>
Subject: Re: I2C not working in uboot
Date: Tue, 17 Jul 2007 20:54:16 +0530
Message-ID: <c656a4d20707170824r68b3adc4y85f42eb8f94bbd39@mail.gmail.com>
References: <c656a4d20707170409g6f9b294eyec6f9f798c9b25d3@mail.gmail.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290170DCCC@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290170DCCC@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

Thanks Woodruff for the reply.
I am able to probe the 4 I2C chips on T2 using iprobe.
The iprobe is giving me output 48,49,4a,4b.(4 chip addresses)

I am able to use the command "imm" and modify the registers(RW).
But while reading back i am getting only zeros, not the values
I have written.

As i understand oamp2430 is having 2 I2C buses.My I2C device
is on bus 2.I think that i am not configuring the second I2C bus.

The following uboot settings are only for I2C bus 1???

#define CFG_I2C_SPEED          100
#define CFG_I2C_SLAVE          1
#define CFG_I2C_BUS            0
#define CFG_I2C_BUS_SELECT     1
#define CONFIG_DRIVER_OMAP24XX_I2C 1

Do i need to configure the second I2C as the same way as given
above???

Best regards
Arun






On 7/17/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> > Please somebody tell me the correct way use the
> > I2C bus for checking the keypad in uboot.
>
> - I'll assume you used the u-boot snapshot from the TI download site for 2430.
>
> - I've used the i2c commands in the past with out issues for 24xx/343x targets.  I've not tried this is a while on 24xx but it worked last time I tried.
>
> - T2 shows up as 4 separate i2c chips.  Below is an example accessing into it.  You should be able to go look at the revision register and others.
>
> - Below is an example writing to the power section to select a high voltage level.  The example was part of some over clocking tests which required a higher voltage.
>
> OMAP34XX SDP # imm 4b b9
> 000000b9: 30 ?
> 000000ba: 00 ?
> 000000bb: 00 ? 43
> 000000bc: 00 ? 43
> 000000bd: 00 ? .
> OMAP34XX SDP # imm 4b b9
> 000000b9: 30 ?
> 000000ba: 00 ? 3
> 000000bb: 43 ? .
>
> Regards,
> Richard W.
>
>
