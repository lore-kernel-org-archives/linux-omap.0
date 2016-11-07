From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: Introduce generic #pinctrl-cells and
 pinctrl_parse_index_with_args
Date: Mon, 7 Nov 2016 08:26:13 -0700
Message-ID: <20161107152613.GA2428@atomide.com>
References: <20161103163550.27330-1-tony@atomide.com>
 <20161103163550.27330-2-tony@atomide.com>
 <CACRpkdaCF4Jc7QY+L44obce=V_W4xgVbPXfuiE7bXJs7ud9q9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaCF4Jc7QY+L44obce=V_W4xgVbPXfuiE7bXJs7ud9q9A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [161104 14:50]:
> On Thu, Nov 3, 2016 at 5:35 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > Introduce #pinctrl-cells helper binding and generic helper functions
> > pinctrl_count_index_with_args() and pinctrl_parse_index_with_args().
> >
> > Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> Ooops applied this v2 version instead of the v1.

No problem, only the pinctrl-single patches needed
reposting.

> * kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> [161103 13:29]:
> >    In file included from drivers/pinctrl/core.c:36:0:
> > >> drivers/pinctrl/devicetree.h:29:14: warning: 'struct of_phandle_args' declared inside parameter list will not be visible outside of this
> definition or declaratio
> 
> > Hmm maybe we should just include of.h in core.c?
> 
> Nah. I just did this:
> 
> diff --git a/drivers/pinctrl/devicetree.h b/drivers/pinctrl/devicetree.h
> index 7f0a5c4e15ad..c2d1a5505850 100644
> --- a/drivers/pinctrl/devicetree.h
> +++ b/drivers/pinctrl/devicetree.h
> @@ -16,6 +16,8 @@
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> 
> +struct of_phandle_args;
> +
>  #ifdef CONFIG_OF
> 
> Let's see if it works!

OK so do we know now? It seems there was one more email
about it but it may have been without it.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
