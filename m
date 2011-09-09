From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 10/11] OMAP: Serial: Allow UART parameters to be configured from board file.
Date: Fri, 09 Sep 2011 12:11:01 -0700
Message-ID: <87zkidtttm.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-11-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:45476 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759534Ab1IITLG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 15:11:06 -0400
In-Reply-To: <1315400013-4849-11-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Wed, 7 Sep 2011 18:23:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Deepak K <deepak.k@ti.com>, Partha Basak <p-basak2@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> The following UART parameters are defined within the UART driver:
>
> 1). Whether the UART uses DMA (dma_enabled), by default set to 0
> 2). The size of dma buffer (set to 4096 bytes)
> 3). The time after which the dma should stop if no more data is received.
> 4). The auto suspend delay that will be passed for pm_runtime_autosuspend
>     where uart will be disabled after timeout
>
> Different UARTs may be used for different purpose such as the console,
> for interfacing bluetooth chip, for interfacing to a modem chip, etc.
> Therefore, it is necessary to be able to customize the above settings
> for a given board on a per UART basis.
>
> This change allows these parameters to be configured from the board file
> and allows the parameters to be configured for each UART independently.
>
> If a board does not define its own custom parameters for the UARTs, then
> use the default parameters in the structure "omap_serial_default_info".
> The default parameters are defined to be the same as the current settings
> in the UART driver to avoid breaking the UART for any board. By default,
> make all boards use the default UART parameters.
>
> Signed-off-by: Deepak K <deepak.k@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Who is the author of this patch?  The first version says Jon[1], v2 says
Deepak[2].  Either way, please ensure proper authorship is attributed
using From: at the beginning of the changelog.  (git-format-patch will
do this for you when the authorship is correct in the git history.)

Even better would be to summarize the changes since the first version
after the '---' so it would be clearer why the authorship was changed.

Only 1/3 of my comments from v3 were addressed in this version.  Please
re-read my comments there[3]. 

Kevin


[1] http://marc.info/?l=linux-omap&m=129890257812478&w=2
[2] http://marc.info/?l=linux-omap&m=130408096416887&w=2
[3] http://marc.info/?l=linux-omap&m=130896078622810&w=2
