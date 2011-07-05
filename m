From: Gerber Patrick <Patrick.Gerber@heig-vd.ch>
Subject: RTC backup on omap3 (overo)
Date: Tue, 5 Jul 2011 14:35:12 +0000
Message-ID: <AD1D79D65ED429499381113CFECBBE48128DA6CF@EINTMBX02.einet.ad.eivd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: fr-CH
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello every one,

I am using an over Fire with an omap3530. I have added a small Lithium backup battery to the TWL4030 for RTC backup as recommanded by Gumstix.
I have tried to set the time with date command and shutdown the overo and remove power. After restart the date is not the one that I have set but a default one (always the same).

Does anybody have already experienced this ? Do you have any idea ?

Thanks in advance

Patrick
