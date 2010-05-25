From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM:VFPv3:enable {d16-d31} access
Date: Tue, 25 May 2010 19:57:41 +0100
Message-ID: <20100525185741.GB16204@n2100.arm.linux.org.uk>
References: <tarun.kanti@ti.com> <1274818736-26597-1-git-send-email-tarun.kanti@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36738 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab0EYS5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 May 2010 14:57:53 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, May 25, 2010 at 02:39:17PM +0530, DebBarma, Tarun Kanti wrote:
>  #ifdef CONFIG_VFPv3
>  	@ d16 - d31 registers
> -	.irp	dr,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> -1:	mrrc	p11, 3, r0, r1, c\dr	@ fmrrd	r0, r1, d\dr
> +	.irp	dr,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
> +1:	fmrrd	r0, r1, d\dr

The existing code is correct.

For every fmrrd instruction, there is a corresponding mrrc version which
assembles to exactly the same opcode.

mrrc instructions take:

1. Co-processor number, range 0-15.
2. Opcode number N, range 0-15.
3. Destination register 1, range 0-15.
4. Destination register 2, range 0-15.
5. Co-processor register number R, range 0-15.

For fmrrd encodings, the first 16 registers are encoded using N=1 with
R=0 to 15.  The second 16 registers are encoded using N=3 with R=0 to 15.
Specifying a co-processor register number greater than 15 is illegal,
hence why the 'irp' specifies the numbers 0 to 15.

If we look at the instruction encodings, for MRRC:

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
|  cond |1 1 0 0 0 1 0 1|  Rn   |  Rm   |CP Num |   N   |   R   |

For FMRRD:

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
|  cond |1 1 0 0 0 1 0 1|  Rn   |  Rm   |1 0 1 1 0 0 M 1|   R   |

where "M" and "R" together define the register.

As I said above, the existing code is correct.  What problem are you
actually trying to solve here?
