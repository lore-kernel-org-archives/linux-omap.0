From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v2] SDMA: Fixing bug in omap_dma_set_global_params()
Date: Wed, 7 Oct 2009 14:48:26 +0530
Message-ID: <618f0c910910070218q496eeb9dgf200ffd5d6583aef@mail.gmail.com>
References: <1254732163-3509-1-git-send-email-anuj.aggarwal@ti.com>
	 <20091005094102.1385b418.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751478AbZJGJTF@vger.kernel.org>
In-Reply-To: <20091005094102.1385b418.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 5, 2009 at 10:11 PM, Randy Dunlap <rdunlap@xenotime.net> wr=
ote:
> On Mon, =A05 Oct 2009 14:12:43 +0530 Anuj Aggarwal wrote:
>
>> Argument tparams was not being used to program
>> global register GCR.HI_THREAD_RESERVED. This patch fixes the same.
>>
>> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
>> ---
>> =A0arch/arm/plat-omap/dma.c | =A0 15 +++++++++------
>> =A01 files changed, 9 insertions(+), 6 deletions(-)
>
>
> Hi,
> Someone please convert all of this source file to correct kernel-doc =
notation.
>
> Thanks.
>

I now have this on my TODO list. As a bug fix, shouldn't this be
pulled in and the doc updates for all the functions can be done as a
separate patch ?
Anuj,
 Can you please correct the comments for this function to proper
format along with your changes ?

Thanks,
Venkat.
