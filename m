From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: RE: [omapzoom] Dspbridge binaries
Date: Fri, 22 Aug 2008 21:42:20 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53445FC118@dlee03.ent.ti.com>
References: <8cef9d540808221930k2f88d9eeib8a6923a346c6ae2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbYHWCm3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2008 22:42:29 -0400
In-Reply-To: <8cef9d540808221930k2f88d9eeib8a6923a346c6ae2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stalin Kenny <stalinlinux@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Omar,

> You can find dspbridge binaries uploaded into omapzoom site:
>
> http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=132
>
Thanks. Are these binaries compatible with the Bridge driver on 3/4+ tree ?

- Yes, they're

> Base images (.dof64P) are statically linked DSP executables loaded on the DSP when system boots up, dynamic libraries (.dll64P) are DSP object files that can be loaded into virtually any address on the DSPloading examples. For more information please refer to the Readme file (in the previous link) or db_linux_rguide.pdf found at:
>
I think you mean db_linux_pguide.pdf and not db_linux_rguide.pdf

- Tricked you to download the other one :), yes I mean db_linux_pguide.pdf

BR,
Stalin

On Fri, Aug 22, 2008 at 8:51 PM, Ramirez Luna, Omar <x00omar@ti.com> wrote:
> Hi,
>
> You can find dspbridge binaries uploaded into omapzoom site:
>
> http://omapzoom.org/gf/project/omapbridge/frs/?action=FrsReleaseView&release_id=132
>
> Base images (.dof64P) are statically linked DSP executables loaded on the DSP when system boots up, dynamic libraries (.dll64P) are DSP object files that can be loaded into virtually any address on the DSPloading examples. For more information please refer to the Readme file (in the previous link) or db_linux_rguide.pdf found at:
>
> http://omapzoom.org/gf/project/omapbridge/docman/?subdir=3
>
> - omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

