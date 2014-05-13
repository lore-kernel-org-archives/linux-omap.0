From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 06/17] pci: host: pcie-designware: Use *base-mask* for configuring the iATU
Date: Tue, 13 May 2014 15:27:46 +0200
Message-ID: <202752041.rgamje4etj@wuerfel>
References: <1399383244-14556-1-git-send-email-kishon@ti.com> <10531498.kYV5eO1J1m@wuerfel> <53721D7F.9070200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53721D7F.9070200-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Santosh Shilimkar' <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, 'Bjorn Helgaas' <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, 'Marek Vasut' <marex-ynQEQJNshbs@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 13 May 2014 18:56:23 Kishon Vijay Abraham I wrote:
> > If you have a case where the outbound translation is a 256MB (i.e. 28bit)
> > section of the CPU address space, that could be represented as
> > 
> >       ranges = <0x82000000 0 0  0xb0000000  0 0x10000000>;
> > 
> > or 
> > 
> >       ranges = <0x82000000 0 0xb0000000  0xb0000000  0 0x10000000>;
> > 
> > depending on whether you want the BARs to be programmed using a low
> > address 0x0-0x0fffffff or an address matching the window
> > 0xb0000000-0xbfffffff.
> 
> The problem is, for configuring the window starting at 0xb0000000, the ATU
> should be programmed 0x0000000 (the cpu address for it will be 0xb0000000 though).
> 

Then use the first of the two?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
