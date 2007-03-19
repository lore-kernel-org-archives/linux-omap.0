From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: TSC2101/2102
Date: Mon, 19 Mar 2007 11:02:30 +0900
Message-ID: <00f201c769ca$a8e022c0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <20070309140650.GC4399@bitbox.mine.nu>
	<fb249edb0703090623o367ec663h85dc581644cb258d@mail.gmail.com>
	<45F7F6D4.20203@gmail.com> <20070314170952.GB10230@bitbox.mine.nu>
	<002801c7669f$d0fe2be0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070315102325.GA4555@bitbox.mine.nu>
	<004901c76762$06d66bc0$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316074157.GA1133@bitbox.mine.nu>
	<004401c767a1$f1489590$c7a3580a@swcenter.sec.samsung.co.kr>
	<20070316094926.GA4519@bitbox.mine.nu>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <20070316094926.GA4519@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Imre Deak' <imre.deak@solidboot.com>
Cc: 'Linux OMAP ML' <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Imre Deak,

> 
> Could you try it with debugging enabled in omap2_mcspi? Would 
> be interesting
> to see where the problem is.

Before read/write I set the these values for TSC2101 intialization

write-32 08600016
write-32 08a00008
write-32 08400000
write-32 09a00900
write-32 08204000
write-32 08008bf4

If we set four read data

write-32 80000000
read-32 ffff0a9b
write-32 80200000
read-32 ffff064f
write-32 80400000
read-32 ffff055f
write-32 80600000
read-32 ffff0deb

and if not

write-32 80000000
read-32 ffff0c4b
write-32 70616d6f
read-32 ffffffff
write-32 6364755f
read-32 ffffffff
write-32 00000000
read-32 ffffffff
--repeat forever--

I think tsc2101 increase the its address automatically. but it's not work at 32-
bit mode.
I also tried to change the format and values "tsc2101_ts_read_data" but it's
same situation.

Ah, a few days ago, tsc2301 driver is merged in omap tree. Why don't you
consider the tsc2301 driver too?
Because I tried to use tsc2102 driver before, but it's not work well. but
tsc2301 is working well.

tsc2xxx driver? I heard tsc2301 is super set of tsc210x, (the bigger chip
number, the more functions)

There's some issue related with omap2_mcspi inferface.
If I use the 32-bit mode, it required the 32-bit data buffer address. so we
mask the read results like this

static void tsc2101_ts_rx(void *arg)
{
        x  = ts->data[0] & 0xffff;
        y  = ts->data[1] & 0xffff;
        z1 = ts->data[2] & 0xffff;
        z2 = ts->data[3] & 0xffff;
}

What's the better approcahes to address this problem?
1. modify the omap2_mcspi source
2. mask the results
3. others.

Thank you,
Kyungmin Park
