From: mirmit <mirmit@bouillot.org>
Subject: Re: OMAP1710 - Accessing audio codec from arm cpu
Date: Tue, 12 Jun 2007 11:55:07 +0200
Message-ID: <986017390706120255n1b5336b2ub696e9174df1ec9a@mail.gmail.com>
References: <9057093.1181555121733.JavaMail.root@ps5>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9057093.1181555121733.JavaMail.root@ps5>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "lbozzi@tiscali.it" <lbozzi@tiscali.it>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Are you talking about N80 or N800? N80 is not running Linux - out of the box
- and more likely doesn't expose API to talk with the DSP or control the
hardware. However, there is plenty of API to take advantage of the
multimedia peripheral of the device.

Maybe you can elaborate a bit.

Mirmit

2007/6/11, lbozzi@tiscali.it <lbozzi@tiscali.it>:
>
>
> Hi all,
>
> I'm a newbie in omap architectures, so I beg your pardon If my question
> has an obvious answer.
>
> I'd like to know if it's possible read/write audio samples in omap1710
> (it's a Nokia N80) directly from arm cpu, "bypassing" C55xx DSP. I'm
> developing a custom application for such a device but cannot modify DSP
> code.
>
> Thanks in advance for your replies,
>
> Best Regards,
>
> --Luciano BOZZI
> Naviga e telefona senza limiti con Tiscali
> Scopri le promozioni Tiscali Adsl: navighi e telefoni senza canone Telecom
> http://abbonati.tiscali.it/adsl/
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
