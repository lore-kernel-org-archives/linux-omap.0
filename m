From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP SMPS regulator driver
Date: Thu, 14 Jul 2011 10:24:24 +0300
Message-ID: <1310628264.4331.108.camel@sokoban>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com> <87ipr5n21x.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55554 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553Ab1GNHY3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jul 2011 03:24:29 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87ipr5n21x.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, "Girdwood, Liam" <lrg@ti.com>

On Thu, 2011-07-14 at 02:22 +0200, Hilman, Kevin wrote:
> Hi Tero,
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Based on the comments for the previous version of this set, I implemented
> > a regulator driver for the OMAP SMPS now. 
> 
> Could you rebase this on my pm-wip/voltdm branch where I've started the
> work to separate out the VC/VP layers into their own files.
> 

I'll do this for next version.

> I've just rebased that branch on top of current l-o master, so it also
> includes all the PRCM core code changes queued for v3.1.
> 
> Thanks,
> 
> Kevin



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

