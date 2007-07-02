From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: Why does it increase the dsor value in MMC?
Date: Mon, 2 Jul 2007 11:14:10 +0900
Message-ID: <002701c7bc4e$b1c70670$e1ac580a@swcenter.sec.samsung.co.kr>
References: <3E32F84CD6CB95498A35B353CA3B930C0672DD@fioues08.ebgroup.elektrobit.com>
	<9C23CDD79DA20A479D4615857B2E2C47013BF5FA@dlee13.ent.ti.com>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <9C23CDD79DA20A479D4615857B2E2C47013BF5FA@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "'Syed Mohammed, Khasim'" <x0khasim@ti.com>, Tuukka.Tikkanen@elektrobit.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 
> >Removing the line improves performance for most people, but might break
> >some hardware combinations (the above case). If you can verify from TRM
> >that the value written to register is the actual divisor (and not like
> >1=0, 2=1 etc),
> It is like this, writing 0 will disable the clock and 1 to 0x3FF are valid
> values.

Then how about to append the following code?

/* If the dsor is zero, we increase the dsor value to enable the clock */
if (dsor == 0)
	dsor++;

It not only assigns the correct dsor values, but also enables the other
platform. 

Thank you,
Kyungmin Park
