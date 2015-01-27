From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dtc: parser: Add label while overriding nodes
Date: Tue, 27 Jan 2015 17:34:31 -0600
Message-ID: <CAL_Jsq+w7R=99qPc+YG_Bh1L-nMs1Gptjwo=KYTK5OX2HVVNpA@mail.gmail.com>
References: <1420726362-22555-1-git-send-email-nikhil.nd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420726362-22555-1-git-send-email-nikhil.nd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-compiler-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
Cc: devicetree-compiler-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 8, 2015 at 8:12 AM, Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org> wrote:
> Current device tree compiler allows to define multiple labels when defining
> the device node the first time. Typically device nodes are defined in
> DTSI files. Now these nodes can be overriden for updating some of the
> properties. Typically, device nodes are overridden in DTS files.
>
> When working with adapter boards, most of the time adapter board can fit to
> multiple base boards. But depending on which base board it is connected to,
> the devices on the adapter board would be children of different devices.
>
> e.g. On dra7-evm.dts, i2c2 is exported for expansion connector whereas
> on dra72-evm.dts, i2c5 is exported for expansion connector.
> This causes a problem when writing a generic device tree file for
> the adapter board. Because, you cannot know wheather all the devices on

s/wheather/whether/

> adpter board are present on i2c or i2c5.

s/adpter/adapter/

> The problem can be solved by adding a common label (e.g. i2cexp) in both
> of the DTS files when overriding the device nodes for i2c2 or i2c5.
> This way, generic adapter board file would override the i2cexp. And
> depending on which base board you use the adpter board, all the devices

s/adpter/adapter/

> are automatically added for correct device nodes.
>
> Change-Id: I3ad7247a79baed7268a91fc691360aece73d6d1b

Get rid of this Gerrit nonsense.

> Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
> ---
>  scripts/dtc/dtc-parser.y |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

You need to send this against upstream dtc, not the copy in the kernel.

Seems like a reasonable change, but I'm not too familar with dtc source.

> diff --git a/scripts/dtc/dtc-parser.y b/scripts/dtc/dtc-parser.y
> index f412460..d9ed3b7 100644
> --- a/scripts/dtc/dtc-parser.y
> +++ b/scripts/dtc/dtc-parser.y
> @@ -145,6 +145,18 @@ devicetree:
>                 {
>                         $$ = merge_nodes($1, $3);
>                 }
> +
> +       | devicetree DT_LABEL DT_REF nodedef
> +               {
> +                       struct node *target = get_node_by_ref($1, $3);
> +
> +                       add_label(&target->labels, $2);
> +                       if (target)
> +                               merge_nodes(target, $4);
> +                       else
> +                               print_error("label or path, '%s', not found", $2);
> +                       $$ = $1;
> +               }
>         | devicetree DT_REF nodedef
>                 {
>                         struct node *target = get_node_by_ref($1, $2);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree-compiler" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
