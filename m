From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 4/9] mailbox: create opened message type
Date: Fri, 21 Dec 2012 10:28:47 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC9CE7A@DBDE01.ent.ti.com>
References: <1355836212-17956-1-git-send-email-loic.pallardy-ext@stericsson.com>
 <1355836212-17956-5-git-send-email-loic.pallardy-ext@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1355836212-17956-5-git-send-email-loic.pallardy-ext@stericsson.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Loic Pallardy <loic.pallardy-ext@stericsson.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "Anna, Suman" <s-anna@ti.com>, Russell King <linux@arm.linux.org.uk>, Loic PALLARDY <loic.pallardy@st.com>, Arnd Bergmann <arnd@arndb.de>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Gutierrez,
 Juan" <jgutierrez@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Wim Van Sebroeck <wim@iguana.be>, Dom Cobley <popcornmix@gmail.com>, Tejun Heo <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 18, 2012 at 18:40:07, Loic Pallardy wrote:
> Current message type is a u32 to fit HW fifo format.
> This should be extended to support any message exchanges
> and type of mailbox.
> Propose structure owns the original u32 and an optional
> pointer on additional data.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/mailbox/Kconfig         |  9 ++++++
>  drivers/mailbox/mailbox-omap1.c | 18 ++++++------
>  drivers/mailbox/mailbox-omap2.c | 10 ++++---
>  drivers/mailbox/mailbox.c       | 64 +++++++++++++++++++++++++++++------------
>  drivers/mailbox/mailbox.h       |  6 ++--
>  include/linux/mailbox.h         | 17 ++++++++++-
>  6 files changed, 89 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index d1e7d74..efb766f 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -33,4 +33,13 @@ config MBOX_KFIFO_SIZE
>           This can also be changed at runtime (via the mbox_kfifo_size
>           module parameter).
>  
> +config MBOX_DATA_SIZE
> +	int "Mailbox associated data max size (bytes)"
> +	default 64
> +	help
> +	  Specify the default size of mailbox's associated data buffer
> +	  (bytes)
> +          This can also be changed at runtime (via the mbox_kfifo_size
> +          module parameter).
> +
>  endif
> diff --git a/drivers/mailbox/mailbox-omap1.c b/drivers/mailbox/mailbox-omap1.c
> index 31cb70a..94e90af 100644
> --- a/drivers/mailbox/mailbox-omap1.c
> +++ b/drivers/mailbox/mailbox-omap1.c
> @@ -50,26 +50,26 @@ static inline void mbox_write_reg(u32 val, size_t ofs)
>  }
>  
>  /* msg */
> -static mbox_msg_t omap1_mbox_fifo_read(struct mailbox *mbox)
> +static int omap1_mbox_fifo_read(struct mailbox *mbox, struct mailbox_msg *msg)
>  {
>  	struct omap_mbox1_fifo *fifo =
>  		&((struct omap_mbox1_priv *)mbox->priv)->rx_fifo;
> -	mbox_msg_t msg;
>  
> -	msg = mbox_read_reg(fifo->data);
> -	msg |= ((mbox_msg_t) mbox_read_reg(fifo->cmd)) << 16;
> +	msg->header = mbox_read_reg(fifo->data);
> +	msg->header |= ((mbox_msg_t) mbox_read_reg(fifo->cmd)) << 16;

Now that struct mailbox_msg encapsulates the data, you can
get rid of the mbox_msg_t typedef completely. Having the data
as part of the mailbox_msg along with the functions with mbox_msg_t
as the return type just creates confusion IMHO.
 
>  
> -	return msg;
> +	return 0;
>  }

Convert all return 0 functions to void?

[...]

>  
> diff --git a/include/linux/mailbox.h b/include/linux/mailbox.h
> index 18c9502..d256e1a 100644
> --- a/include/linux/mailbox.h
> +++ b/include/linux/mailbox.h
> @@ -7,7 +7,22 @@ typedef int __bitwise mailbox_irq_t;
>  #define IRQ_TX ((__force mailbox_irq_t) 1)
>  #define IRQ_RX ((__force mailbox_irq_t) 2)
>  
> -int mailbox_msg_send(struct mailbox *, mbox_msg_t msg);
> +struct mailbox_msg {
> +	int		size;
> +	u32		header;
> +	void		*pdata;
> +};
> +
> +#define MAILBOX_FILL_MSG(_msg, _header, _pdata, _size) { \
> +	_msg.header = _header; \
> +	_msg.pdata = (void *)_pdata; \
> +	_msg.size = _size; \
> +}
> +
> +#define MAILBOX_FILL_HEADER_MSG(_msg, _header) \
> +	MAILBOX_FILL_MSG(_msg, _header, NULL, 0);
> +

I used these patches as part of the suspend-resume support for AM335x
which has the same mailbox IP as OMAP4. I used the MAILBOX_FILL_HEADER_MSG
helper and things work as expected.

However, I found the 'header' part to be very confusing. Why not treat the
OMAP case as a special case of the new MAILBOX_FILL_MSG where the data size
is set to 1?

Regards,
Vaibhav
