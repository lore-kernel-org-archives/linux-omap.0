From: "Juha Kuikka" <juha.kuikka@gmail.com>
Subject: Re: Data abort issue
Date: Fri, 21 Sep 2007 09:50:40 -0700
Message-ID: <a46a26fd0709210950i3f5cac36h758811d995354cc4@mail.gmail.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6D3@ntxsjombx02.micron.com>
	<a46a26fd0709201310ye0c3c96ib246dfdf114a02a9@mail.gmail.com>
	<809D758398CC1F49AA8E493528AD4A27014DF6D4@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6D4@ntxsjombx02.micron.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "sshahrom@micron.com" <sshahrom@micron.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Shahrom,

Thanks for the reply.

Maybe linux kernel handles unaligned data access gracefully inside the
kernel. In userspace I've noticed that it terminates the process.

I've put your code into u-boot and it crashes on this line with "data
abort'.

I implemented similar fix.

 - Juha

On 9/21/07, sshahrom@micron.com <sshahrom@micron.com> wrote:
>
> Hello Juha,
> I have not seen that in linux kernel in version 2.6.21 or 2.6.23, I also
> use following gcc,
> gcc version 3.4.0 20040409 (CodeSourcery ARM Q1A 2004)
> gcc version 4.1.1 (CodeSourcery Sourcery G++ 2006q3-27)
>
> Bootloader would cause data abort, and work around for that is:
>         isEccFF  = ((*(u8 *)ecc_data1   & 0x00) == 0x00);
>         isEccFF |= ((*(u8 *)ecc_data1++ & 0xFF) == 0xFF);
>         isEccFF |= ((*(u8 *)ecc_data1++ & 0xFF) == 0xFF);
>         isEccFF |= ((*(u8 *)ecc_data1++ & 0xFF) == 0xFF);
> I hope that helped,
> -Shahrom
>
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com [mailto:
> linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Juha Kuikka
> Sent: Thursday, September 20, 2007 1:10 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Re: [PATCH 4/4] [MTD] NAND : Resubmitting support for 2K page
> nand
>
> Hi Shahrom,
>
> I ran into one problem with this code.
>
> This line:
> isEccFF = ((*(u32 *)ecc_data1 & 0xFFFFFF) == 0xFFFFFF); in
> omap_compare_ecc will cause data abort on ARM as the pointer is not properly
> aligned for double word access.
>
> - Juha
>



-- 
Madness takes it's toll. Please have exact change.
