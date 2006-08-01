From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: Problem booting in OMAP H3 1710
Date: Tue, 01 Aug 2006 17:24:10 -0400
Message-ID: <44CFC67A.7090208@indt.org.br>
References: <44C4E6CD.3020303@indt.org.br> <20060725102626.GA2143@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060725102626.GA2143@localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext imre.deak@solidboot.com" <imre.deak@solidboot.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext imre.deak@solidboot.com wrote:

>Hi,
>
>On Mon, Jul 24, 2006 at 11:27:09AM -0400, Carlos Aguiar wrote:
>  
>
>>Hello folks,
>>
>>I'm trying to boot a kernel image to OMAP H3 1710 generated from
>>linux-omap-2.6.git (v2.6.17-omap1) tree, but I'm having the following
>>problem (kernel panic) below.
>>
>>This kernel image it's with 'Kernel low-level debugging functions' support.
>>
>>Is there anybody having the same problem ?
>>    
>>
>
>I think this bug was fixed by
>http://linux.omap.com/pipermail/linux-omap-open-source/2006-July/007515.html
>
>It's been also pushed to the omap tree yesterday. Could you check
>if you have it locally?
>
>--Imre
>
>  
>
>>Thanks in advance,
>>
>>Carlos.
>>
>>...
>>
>><6>omapfb: configured for panel h3
>><6>omapfb: LCDC initialized
>><1>Unable to handle kernel paging request at virtual address 00009600
>><1>pgd = c0004000
>><1>[00009600] *pgd=00000000
>>Internal error: Oops: 805 [#1]
>>Modules linked in:
>>CPU: 0
>>PC is at cfb_imageblit+0x210/0x49c
>>LR is at 0x6
>>pc : [<c01000b8>]    lr : [<00000006>]    Not tainted
>>sp : c02b39e4  ip : c02c0000  fp : c02b3a54
>>r10: 00000002  r9 : c02c0000  r8 : 00000000
>>r7 : c01f75a8  r6 : 00000000  r5 : c034f800  r4 : 00009600
>>r3 : 00000000  r2 : 00000007  r1 : 00000002  r0 : 00000004
>>Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
>>Control: 5317F  Table: 10004000  DAC: 00000017
>>Process swapper (pid: 1, stack limit = 0xc02b2198)
>>    
>>
>
>
>  
>
Hi Imre and folks,

I was testing by disabling the 'OMAP frame buffer support
(EXPERIMENTAL)' support option but the modification you mentioned in the
link works fine on H3 1710.

Thanks,

Carlos.

-- 
Carlos Eduardo
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
