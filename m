From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCH 5/11] Adding OMAP3430 support to mach-omap2
Date: Wed, 30 May 2007 20:01:09 -0500
Message-ID: <465E1E55.2060001@gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0E31@dlee13.ent.ti.com>
	<200705301002.55697.kraj@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200705301002.55697.kraj@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Khem Raj <kraj@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Khem Raj stated on 5/30/2007 12:02 PM:
> OMAP3430 being a omap3 family shouldn't this be be added in 
> arch/arm/mach-omap3?
>   
The files can either be reused from plat-omap or mach-omap2. 3430
closely follows 2420->2430 family line and adds more features and a new
ARM core (slightly unlike the jump in features from 1710->2420). IMHO,
does not make sense to call it mach-omap3..
Regards,
Nishanth Menon
