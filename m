From: "arun c" <arun.edarath@gmail.com>
Subject: Re: touch screen on 2430sdp not giving X and Y values
Date: Mon, 29 Oct 2007 16:05:47 +0530
Message-ID: <c656a4d20710290335h5f754ee2nf4eea969366530d1@mail.gmail.com>
References: <c656a4d20710282330x74dc71e0x68ca6c5309c3b643@mail.gmail.com>
	<001701c819fc$7d6dcce0$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001701c819fc$7d6dcce0$6a8918ac@ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/29/07, Girish <girishsg@ti.com> wrote:
>
>
> >But how can i check the Touch Screen interface power???  you
> >mean hardware wise checking??
>
> I guess vaux2 has to be enabled for TS to work on 2430sdp, you can
> Cross check in TRM.

Power supply is OK, i think so because everything is
working fine on CSST diagnostics tests.

Below i am pasting the kernel debug messages.

omap_tsc2046_handler Entry
omap_tsc2046_handler[410]:Exit(0)
omap_tsc2046_tasklet Entry
pen_down Entry
pen_down[249]:Exit(0)
omap_tsc2046_read_buf Entry
omap_tsc2046_read_buf [299]
 values[0]=-2147483648
omap_tsc2046_read_buf [299]
 values[1]=-754974720
omap_tsc2046_read_buf [299]
 values[2]=-1828716544
omap_tsc2046_read_buf [299]
 values[3]=-1291845632
omap_tsc2046_read_buf [299]
 values[4]=-1023410176
getdata Entry
getdata [257] data1 : -1828716544        data2:-1291845632

getdata Entry
getdata [257] data1 : -754974720         data2:-1828716544

getdata Entry
getdata [257] data1 : -1291845632        data2:-1023410176

getdata Entry
getdata [257] data1 : -1023410176        data2:0

omap_tsc2046_read_buf [317] X : 0        Y:0     P : 0

omap_tsc2046_read_buf[332]:Exit(0)
omap_tsc2046_tasklet[366]:Exit(0)
omap_tsc2046_timer Entry
pen_down Entry
pen_down[249]:Exit(1)
omap_tsc2046_timer[395]:Exit(0)

The problem is that for all the presses i am getting

X=0               Y=0              and  P=0
what could be the problem????? please somebody help me

Regards,
Arun
