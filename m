From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8] ASoC: omap-mcbsp: Add PM QoS support
 for McBSP to prevent glitches
Date: Wed, 18 Jan 2017 09:35:45 -0800
Message-ID: <20170118173545.GF7403@atomide.com>
References: <20170118072600.15239-1-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170118072600.15239-1-matt@ranostay.consulting>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Ranostay <matt@ranostay.consulting>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Matt Ranostay <matt@ranostay.consulting> [170117 23:27]:
> Changes from v7:
> * fix issue reported by Tony Lindgreen that a player application could close the
>   card after hw_params, and cause an invalid pm_qos_remove_request()

OK this version works for me nicely :)

Thanks for taking care of the issue in general:

Tested-by: Tony Lindgren <tony@atomide.com>
