From: Matthew Percival <matthew@capgo.com>
Subject: Re: How much is OMAP5912 HDQ clock speed?
Date: Tue, 22 Nov 2005 08:58:32 +1100
Message-ID: <1132610312.8832.3.camel@localhost.localdomain>
References: <BAY114-F249A4F49A1B2B148F7EC14EA530@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY114-F249A4F49A1B2B148F7EC14EA530@phx.gbl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP Open Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

G'Day,

>   I'm building a system based on OMAP5912 with battery monitor.
>   Application note SlUA319(HDQ Compatibility Between OMAP and bq Products) 
> says most of TI bq(e.g,bq2019) battery monitor use HDQ protocal and is not 
> compatible with all OMAP. But i didn't find OMAP5912 HDQ engine timing.
>   Is there anyone knowing that?Thank you.

	You should find everything you need in the current silicon errata
(sprz209).  You can find the current revision of this document here:
		http://focus.ti.com/lit/er/sprz209f/sprz209f.pdf

	-- Matthew
