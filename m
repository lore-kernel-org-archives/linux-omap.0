From: "Franklin S Cooper Jr." <fcooper@ti.com>
Subject: Re: [PATCH 1/2 v2] ARM: DRA7/335x/437x/OMAP4: hwmod: Remove elm
 address space from hwmod data
Date: Mon, 26 Oct 2015 09:50:16 -0500
Message-ID: <562E3DA8.4000006@ti.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com>
 <alpine.DEB.2.02.1510231858170.9575@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1510231858170.9575@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org



On 10/23/2015 02:00 PM, Paul Walmsley wrote:
> On Thu, 15 Oct 2015, Franklin S Cooper Jr wrote:
>
>> ELM address information is provided by device tree. No longer need
>> to include this information within hwmod.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> The OMAP4 DTS files don't have the ELM address space declared.  I'm going 
> to drop that portion of your patch.  Could you please send a two-patch 
> series that first adds the ELM address space to the OMAP4 DTS file and 
> then subsequently drops it from the OMAP4 hwmod data file?
Hi Paul,

Sorry about that. I can create the patches but I don't see any board omap4
board that has nand support. So I'm not going to be able to test to insure if
omap_elm.c will work as is.

Should I just drop omap4 from this patchset or should I just add the elm node
to omap4.dtsi and if people report an issue with omap_elm then we can fix it?


>
>
> - Paul
