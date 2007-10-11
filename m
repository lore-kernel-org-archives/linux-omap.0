From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH 11/12] musb_hdrc: Allow suspend if host is already
	suspended
Date: Thu, 11 Oct 2007 23:07:28 +0300
Message-ID: <31e679430710111307s57a7f415n9b3ef2cfefe60c9e@mail.gmail.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
	<11921223372253-git-send-email-tony@atomide.com>
	<11921223381405-git-send-email-tony@atomide.com>
	<11921223392718-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223392718-git-send-email-tony@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 10/11/07, Tony Lindgren <tony@atomide.com> wrote:
> Allow suspend if host is already suspended
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 091ae8f..4eeff91 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -2128,6 +2128,9 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
>  {
>         struct musb     *musb = hcd_to_musb(hcd);
>
> +       if (musb->xceiv.state == OTG_STATE_A_SUSPEND)
> +               return 0;
> +

Should we allow this ? If it's already suspended it doesn't make sense
suspending again. And in OTG state machine there's no way to suspend a
suspended device i.e. no loop going back to [ab]_suspend state.

In any case, if it works... ;-)

>         if (is_host_active(musb) && musb->is_active) {
>                 WARN("trying to suspend as %s is_active=%i\n",
>                         otg_state_string(musb), musb->is_active);
> --
> 1.5.2.5
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
