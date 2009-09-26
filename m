From: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [PATCH 0/2] mfd: restoring twl4030 power-off and power-button
	capabilities
Date: Fri, 25 Sep 2009 19:49:22 -0700
Message-ID: <ce9ab5790909251949s71083c3brd625d36653387cc8@mail.gmail.com>
References: <52241.192.168.10.89.1251990701.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753145AbZIZCtk@vger.kernel.org>
In-Reply-To: <52241.192.168.10.89.1251990701.squirrel@dbdmail.itg.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Since there are no comments on these patches, can these go upstream?
Or, is there something to fix?

--vimal

On Thu, Sep 3, 2009 at 8:11 AM, vimal singh <vimalsingh@ti.com> wrote:
> This patch series restores the TWL Power-button and Power-off capabil=
ities.
> Which were removed in "REMOVE OMAP LEGACY CODE" patches.
>
> Patches are compile tested only.
>
> [PATCH 1/2]: twl4030: register twl4030-pwrbuttonas a child of twl4030=
-core.c
> [PATCH 2/2]: twl4030: initialization of pm_power_off in twl4030-core.=
c
>
> Both patches are based on Felipe Balbi's patches posted earlier.
> http://lkml.org/lkml/2009/2/28/88
> http://markmail.org/message/ts4if3553qnauket
>
> --
> Vimal
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
