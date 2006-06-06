From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Plea for MMC spec owners
Date: Tue, 06 Jun 2006 23:39:47 +0200
Message-ID: <4485F623.5030403@drzeus.cx>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE4791EA@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE4791EA@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Khasim, Syed" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khasim, Syed wrote:
>
> Pierre, this is clearly defined in spec. It's mandatory for a MMC (of
> any size) to start with a 512M block on a soft reset / power on. 
>   

Then I guess the spec would be self-contradictory as the section you
quoted earlier clearly stated that only READ_BL_LEN/WRITE_BL_LEN was
valid if *_BL_PARTIAL wasn't set.

Rgds
Pierre
