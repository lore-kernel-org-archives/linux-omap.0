From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v3 07/12] OMAP: Serial: Allow UART parameters to be
	configured from board file.
Date: Mon, 27 Jun 2011 18:23:23 +0530
Message-ID: <BANLkTiksPZfsJ9u0dDi5LaxsLtRdA4R2yg@mail.gmail.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-8-git-send-email-govindraj.raja@ti.com>
	<87vcvurcom.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87vcvurcom.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Deepak K <deepak.k@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 25, 2011 at 5:42 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> The following UART parameters are defined within the UART driver:
>>
>> 1). Whether the UART uses DMA (dma_enabled), by default set to 0
>> 2). The size of dma buffer (set to 4096 bytes)
>> 3). The time after which the dma should stop if no more data is received.
>> 4). The auto suspend delay that will be passed for pm_runtime_autosuspend
>> =A0 =A0 where uart will be disabled after timeout
>>
>> Different UARTs may be used for different purpose such as the console,
>> for interfacing bluetooth chip, for interfacing to a modem chip, etc.
>> Therefore, it is necessary to be able to customize the above settings
>> for a given board on a per UART basis.
>>
>> This change allows these parameters to be configured from the board file
>> and allows the parameters to be configured for each UART independently.
>>
>> If a board does not define its own custom parameters for the UARTs, then
>> use the default parameters in the structure "omap_serial_default_info".
>> The default parameters are defined to be the same as the current settings
>> in the UART driver to avoid breaking the UART for any board. By default,
>> make all boards use the default UART parameters.
>>
>> Signed-off-by: Deepak K <deepak.k@ti.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Nice. =A0some minor comments below.
>
> [...]
>
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/pl=
at-omap/include/plat/omap-serial.h
>> index ac30de8..4e2dcdc 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -51,7 +51,12 @@
>>
>> =A0#define OMAP_UART_DMA_CH_FREE =A0 =A0 =A0 =A0-1
>>
>> -#define RX_TIMEOUT =A0 =A0 =A0 =A0 =A0 (3 * HZ)
>> +#define RX_TIMEOUT =A0 =A0 =A0 =A0 =A0 (3 * HZ) =A0 =A0 =A0 =A0/* RX DM=
A timeout (jiffies) */
>> +#define DEFAULT_RXDMA_TIMEOUT =A0 =A0 =A0 =A01 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 /* RX DMA polling rate (us) */
>> +#define DEFAULT_RXDMA_BUFSIZE =A0 =A0 =A0 =A04096 =A0 =A0 =A0 =A0 =A0 =
=A0/* RX DMA buffer size */
>> +#define DEFAULT_AUTOSUSPEND_DELAY (30 * HZ) /* Runtime autosuspend (mse=
cs) */
>
> These don't need to be in omap-serial.h since neither the driver code or
> the board file should be using them. =A0They can stay in mach-omap2/seria=
l.c
>

Yes fine will move them to serial.c

>> +
>> =A0#define OMAP_MAX_HSUART_PORTS =A0 =A0 =A0 =A04
>>
>> =A0#define MSR_SAVE_FLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 UART_MSR_ANY_DELTA
>> @@ -64,6 +69,9 @@ struct omap_uart_port_info {
>> =A0 =A0 =A0 upf_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags; =A0 =A0 =A0=
 =A0 =A0/* UPF_* flags */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0errata;
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0console_uart;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_rx_buf_size;/* DMA Rx =
Buffer Size */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_rx_timeout; /* DMA RX =
timeout */
>
> Comments don't add value over variable name.
>

will drop those comments.

>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0auto_sus_timeout; /* Auto_=
suspend timeout */
>
> rename to autosuspend_timeout, drop comment.

ok.

--
Thanks,
Govindraj.R

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
