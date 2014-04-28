From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ARM: dts: Add support for DRA72x family of devices
Date: Mon, 28 Apr 2014 10:50:51 +0200
Message-ID: <5761706.QaRvAizEZ2@wuerfel>
References: <1398333987-19454-1-git-send-email-rnayak@ti.com> <201404241513.54380.arnd@arndb.de> <535DF092.7000307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <535DF092.7000307-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 28 April 2014 11:39:22 Rajendra Nayak wrote:
> 
> DRA742 EVM:  Software Developement Board for DRA742
> compatible = "ti,dra7-evm", "ti,dra742", "ti,dra74", "ti,dra7"
> DRA722 EVM: Software Development Board for DRA722
> compatible = "ti,dra72-evm", "ti,dra722", "ti,dra72", "ti,dra7"
> 
> I was also calling the .dtsi files as dra72x.dtsi and dra74x.dtsi, do you suggest I call
> them dra742.dtsi and dra722.dtsi instead? Just that if we end up with a dra745 which is
> fully compatible with dra742, as you mentioned above, we would be using a dra742.dtsi for a dra745
> device which could be a little confusing.

For the file names, wildcards are ok. Alternatively you could have
a dra745.dtsi that does nothing but include dra752.dtsi and override
the compatible string (if there is one to start with).

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
