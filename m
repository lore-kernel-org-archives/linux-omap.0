From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: TSC2101/2102
Date: Mon, 19 Mar 2007 10:37:11 +0200
Message-ID: <20070319103711.36ffe999.jarkko.nikula@nokia.com>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
	<004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316074157.GA1133@bitbox.mine.nu>
	<004401c767a1$f1489590$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316094926.GA4519@bitbox.mine.nu>
	<00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070319093721.bd0df13e.jarkko.nikula@nokia.com>
	<010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <010f01c769fd$4ab24d30$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: kmpark@infradead.org
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 19 Mar 2007 17:04:55 +0900
"ext Kyungmin Park" <kmpark@infradead.org> wrote:

> > My copy of the tree is from 
> > ftp://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-oma
> > p-2.6.git. Is it rebased correctly? E.g. last commit in 
> > master branch is from "Fri Feb 16" but "Wed Mar 7" in omap-drivers.
> 
> I usually use the omap git tree in mvista.
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-
> 2.6.git;a=commit;h=a7b9b17c9025066cd05f555bbba5542bcf16df3a
> it was commited at Tue, 13 Mar.
> 
I'll see. That pushed version wasn't very good one. It didn't compile without warnings, etc. I'll send soon few patches in top of it.

Tony, any plans to keep sync kernel.org and mvista.com trees?

> I will send the tsc2101 patch based on tsc2301 files. I think it's complicted
> with Imre's tsc2101 patch. 
> 
How about just keeping both of them separated including config names, header files, etc. for awhile until both are pushed & working. Bit easier first step for us I think :-)


Jarkko
