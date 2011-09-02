From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] OMAP2: clockdomain/powerdomain: remove OMAP_CHIP
	bitmasks
Date: Fri, 2 Sep 2011 15:33:29 +0300
Message-ID: <20110902123328.GW3548@atomide.com>
References: <20110902021321.8185.63172.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110902021321.8185.63172.stgit@dusk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [110902 04:58]:
> Remove the OMAP_CHIP bitmasks from the powerdomain and clockdomain
> code.  In their place, use lists of powerdomains and clockdomains to
> register for particular chips and chip families.
> 
> The intention of this change is to reduce the number of lines that
> need to be patched to add support for new SoCs that are similar to
> previous SoCs.
> 
> This series has been boot-tested on a 2430SDP, BeagleBoard 35xx and
> 37xx, and PandaBoard 44xxES2, but I don't have boards for all of the
> different variants needed for a complete test.
> 
> A git branch is available at git://git.pwsan.com/linux-2.6 based on
> v3.1-rc4 with prcm-fixes-a-3.1rc.

Great! Thanks for working on this. Let's get this tested and merged
into our cleanup branch ASAP as this will simplify adding new omaps
quite a bit :)

Tony
