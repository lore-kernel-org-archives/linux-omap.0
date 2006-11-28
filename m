From: Tony Lindgren <tony@atomide.com>
Subject: Re: bast_defconfig
Date: Tue, 28 Nov 2006 02:28:28 +0000
Message-ID: <20061128022827.GD7763@atomide.com>
References: <3a5b1be00611231256t4128f7d4jedd61b656886ff0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3a5b1be00611231256t4128f7d4jedd61b656886ff0a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal.shah802003@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal.shah802003@gmail.com> [061123 21:03]:
> Tony,
> 
> I think we lost bast_defconfig while merging 2430_defconfig. Hope
> following message indicates the same while I pulled the recent
> -omap-git tree.
> 
> ...
> rename arch/arm/configs/{bast_defconfig => omap_2430sdp_defconfig} (56%)
> ...

Hmm, sounds like some git weirdness. Looks like bast_defconfig was
removed in the mainline kernel.

Tony
