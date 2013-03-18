From: Wolfgang Denk <wd@denx.de>
Subject: Re: [U-Boot] [RFC] Kbuild support for ARM FIT images
Date: Mon, 18 Mar 2013 20:57:25 +0100
Message-ID: <20130318195725.CA8132014B1@gemini.denx.de>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130222160044.GA16357@quad.lixom.net> <20130318163648.GA3722@amd.pavel.ucw.cz> <20130318164426.GI30923@n2100.arm.linux.org.uk> <20130318174931.GB4230@amd.pavel.ucw.cz> <20130318175746.GJ30923@n2100.arm.linux.org.uk> <20130318180458.GC4230@amd.pavel.ucw.cz> <51475997.2060008@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-reply-to: <51475997.2060008@wwwdotorg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Pavel Machek <pavel@denx.de>, "Fernandes, Joel A" <joelagnel@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, tony@atomide.com, Grant Likely <grant.likely@secretlab.ca>, u-boot@lists.denx.de, "Rini, Tom" <trini@ti.com>, Grant Likely <glikely@secretlab.ca>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Dear Stephen,

In message <51475997.2060008@wwwdotorg.org> you wrote:
>
> Raw zImage /is/ the useful format that should be adopted.

This "one size fits all" approch does fit everywhere.  There are a
number of users (including _big_ commercial ones, with _large_ numebrs
of systems in the field) that have simple requirements like:

- how can I find out if the image I just loaded to RAM in OK (OK
  maning some checksum is correct, or some crypto-key could be
  verified, or ...) ?

- how can I find out which version of image is installed on this
  device in the flash?  Can I print something like an ID string, or a
  build timestamp, etc?

etc. etc.

zImage may work well in many cases, but there are also many cases
where in image format that allows for additional meta-data is
mandatory.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Minds are like parachutes - they only function when open.
