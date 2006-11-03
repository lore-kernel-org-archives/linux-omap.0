From: Vishal Borker <vishal@nextbitcpu.com>
Subject: Re: Porting uClinux to OMAP5912
Date: Thu, 02 Nov 2006 19:36:00 -0500
Message-ID: <454A8EF0.4050706@nextbitcpu.com>
References: <1162475009.5390.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1162475009.5390.19.camel@localhost>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sun Chao <lordsunland@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

uClinux on OMAP 5912 - do you intend to run ucLinux on the ARM core ? or 
the DSP core?
The requirements change accordingly. 
If you want to get it up on the ARM, you'd need to disable the mmu.
Getting uCLinux on the DSP would be a whole new thing. toolchain and 
all. :) . Much like what was done with the AD blackfin..

Sun Chao wrote:
> 	Hi every one:
>                 I'm working on a project that will port uClinux on the
>         OMAP 5912 board. Because I'm now a newbie to uClinux and
>         embedded systems, I have some questions:
>                 1. Does the current uClinux support OMAP 5912? When I
>         config the linux 2.6 kernel in uClinux, I can find the choice of
>         TI OMAP, but there are only OMAP 16** and other choices without
>         the OMAP 5912 being included.
>                 2. If I must do some work to make the uClinux be able to
>         run on the OMAP 5912 platform, what shall I do? 
>                 I will be great appreciate for your patient answer.
>   
