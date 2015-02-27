From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: add openpandora device support
Date: Fri, 27 Feb 2015 09:33:39 +0100
Message-ID: <CAAfyv376B4CmzN7gtqdwdOE_URo0ksKDE6GXiiRjqNg0FX6WTw@mail.gmail.com>
References: <1424202743-26387-1-git-send-email-marek@goldelico.com>
	<CANOLnOOMLxDV6vQagfRaS7_YY6at91BbL0jPKkNQn-tYDnJEuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:40926 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbB0Idk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 03:33:40 -0500
In-Reply-To: <CANOLnOOMLxDV6vQagfRaS7_YY6at91BbL0jPKkNQn-tYDnJEuw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, Grazvydas Ignotas <notasas@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony,

should I send v3 (with updates) or can you apply current version? Thanks.

On Thu, Feb 19, 2015 at 11:55 PM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Tue, Feb 17, 2015 at 9:52 PM, Marek Belisko <marek@goldelico.com> wrote:
>> changes from v1:
>> - add new boards to makefile in patch 2,3 (don't add them
>> in separate commit together), fix gpmc issues (reported by Tony Lindgren)
>>
>> - fix various issues reported by Grazvydas Ignotas
>> (drop internal pullups from pinmux as external are in place,
>> fix gpio buttons active state ...)
>>
>> This series of patches adds initial device tree support for the
>> OpenPandora. The most important parts are working (display, keyboard,
>> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
>
> All of these have been tested to be working, after adding missing
> input flag for touchscreen. Well except musb, but I often have trouble
> with that in mainline, probably not a problem with this dts.
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>
> And FWIW, the patches have been
> Reviewed-by: Grazvydas Ignotas <notasas@gmail.com>

Marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
