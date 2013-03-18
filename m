From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 20:51:29 +0100
Message-ID: <20130318195129.D6BC22014B1@gemini.denx.de>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130222160044.GA16357@quad.lixom.net> <20130318163648.GA3722@amd.pavel.ucw.cz> <20130318164426.GI30923@n2100.arm.linux.org.uk> <20130318174931.GB4230@amd.pavel.ucw.cz> <20130318175746.GJ30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-reply-to: <20130318175746.GJ30923@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pavel Machek <pavel@denx.de>, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, linux-kbuild@vger.kernel.org, tony@atomide.com, "Rini, Tom" <trini@ti.com>, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, Joel A Fernandes <agnel.joel@gmail.com>, Olof Johansson <olof@lixom.net>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Dear Russell,

In message <20130318175746.GJ30923@n2100.arm.linux.org.uk> you wrote:
>
> Unfortunately, there is a fundamental problem with uImage.  It encodes
> the load address, and that is utterly incompatible with the goal of
> having a kernel image which boots on multiple platforms.

I'm not sure if you are aware that U-Boot supports uImages that can be
run from _any_ load address (using the IH_TYPE_KERNEL_NOLOAD image
type).  If anybody was willing to keep uImage support in the kernel
this would probably be a convenient way to go.

But in any case, the uImage format is deprecated.  Support for FIT
images was added more than five years ago, and new developments should
rather focus on supporting these.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
