From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/29] PM: proposed branch for PM collaboration
Date: Tue, 16 Sep 2008 16:14:18 +0300
Message-ID: <48CFB12A.4040001@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:61171 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbYIPNOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 09:14:25 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1185986eyi.37
        for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 06:14:22 -0700 (PDT)
In-Reply-To: <87iqt2amoi.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> Hello,
> 
> The following patchset is an attempt to collect the various PM patches
> that have been flowing around, and organize them into one branch to be
> used for further collaboration on PM development, in particular
> OFF-mode support.

This series has been rebased onto today's OMAP git, and pushed as branch 
pm-0.

I will now start collecting more recent versions of these patches and 
newer patches sent to the list for the next version of the branch.

Kevin

> It is currently a collection of proposed patches[1] from TI and
> various other patches from Nokia and others to get retention,
> OFF-mode, CPUidle etc. working in the linux-omap tree.
> 
> This series is nowhere near ready for merging into linux-omap, but
> will be useful for discussion and collaboration on getting the various
> PM features working at the head of the linux-omap tree, and a place
> where cleanup and rework efforts can be focused.  
> 
> If there are no major objections, I will create a branch in linux-omap
> git and commit this series there.  As collaboration continues, I will
> continue to collect and update patches, fix problems and rebase onto
> the HEAD of linux-omap.  
> 
> The goal of this branch is only to facilitate the rework and cleanup
> of the PM code so it can be merged into linux-omap.  Then, the branch
> will disappear and work can be focused again on the HEAD of
> linux-omap.
> 
> It has currently been tested with a minimal config on 3430SDP, and
> OFF-mode is hit in suspend.  In order to hit suspend:
> 
>   echo 1 > /sys/power/voltage_off_while_idle                   
>   echo 1 > /sys/power/gpio_clocks_off_while_idle               
>   echo 1 > /sys/power/uart_clocks_off_while_idle 
>   echo mem > /sys/power/state
> 
> Kevin
> 
> 
> [1] This series is roughly based on the following:
> 
> Jouni Hogander, Tero Kristo
>  [PATCH 0/4] Refreshed PM workaround patches 2 -- 15 Aug
> 
> Rajendra Nayak:
>  [PATCH 00/11] OMAP3 CPUidle patches - ver 2 -- 18 July
> 
> As well as several patches/hacks/cleanups that have not yet been
> posted to the list.
> 
> Also, there have been newer versions of the CPUidle patches that have
> been reviewed on the list, but do not apply for various reasons.  As
> soon as they are rebased and updated versions of those are available,
> I will integrate them.

