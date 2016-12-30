From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] pinctrl: core: Add generic pinctrl functions for
 managing groups
Date: Fri, 30 Dec 2016 15:28:42 +0100
Message-ID: <CACRpkdZZ_zc2GR4+0R_1CPnwUMea6E4L7ewsQuGr91XC=dPRJw@mail.gmail.com>
References: <20161227172003.6517-1-tony@atomide.com> <20161227172003.6517-4-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161227172003.6517-4-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-OMAP <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 27, 2016 at 6:20 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> We can add generic helpers for function handling for cases where the pin
> controller driver does not need to use static arrays.
>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Patch applied.

> +config GENERIC_PINMUX
> +       bool
> +       select PINMUX

I renamed this GENERIC_PINMUX_FUNCTIONS

> +       INIT_RADIX_TREE(&pctldev->pin_function_tree, GFP_KERNEL);

#ifdefed this

> +       struct radix_tree_root pin_function_tree;
>         unsigned int num_groups;
> +       unsigned int num_functions;

#ifdefed these

>  /**
> + * struct function_desc - generic function descriptor
> + * @name: name of the function
> + * @group_names: array of pin group names
> + * @num_group_names: number of pin group names
> + * @data: pin controller driver specific data
> + */
> +struct function_desc {
> +       const char *name;
> +       const char **group_names;
> +       int num_group_names;
> +       void *data;
> +};

And moved this into pinmux.h

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
