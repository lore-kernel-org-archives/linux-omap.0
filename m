From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH 4/4] arm/dts: am33xx: Add CPSW and MDIO module nodes
 for AM33XX
Date: Fri, 2 Nov 2012 09:56:16 +0100
Message-ID: <20121102085616.GB2486@netboy.at.omicron.at>
References: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
 <1351498881-32482-6-git-send-email-hvaibhav@ti.com>
 <50914107.2090909@ti.com>
 <EB1619762EAF8B4E97A227FB77B7E0293EA08F53@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293EA08F53@DBDE01.ent.ti.com>
Sender: netdev-owner@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 02, 2012 at 08:46:46AM +0000, N, Mugunthan V wrote:
> > 
> > Do you expect to have several instance of the same IP with different
> > parameters here?
> 
> Though CPSW is a single IP in AM335X, CPSW has sub modules like CPDMA, ALE,
> SLIVER, CPTS and SLAVES where is IP integrator can locate it at different
> offsets. For example comparing the CPSW ip in TI814X and AM335X all the
> above offsets are changed. So I have kept all these offsets in DT as driver
> should not hold any SoC related informations

Did you see the two messages on this point from yesterday?

Thanks,
Richard
