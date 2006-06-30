From: <Toshihiro.Kobayashi@nokia.com>
Subject: RE: DSPGateway problem with kernel2.6.14
Date: Fri, 30 Jun 2006 14:13:39 +0900
Message-ID: <7AF192DA69C59243838FF62851F64F550285C9BE@toebe101.NOE.Nokia.com>
References: <7e6cc7550606292149y585c24aah60c559bc0b37ebe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7e6cc7550606292149y585c24aah60c559bc0b37ebe0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: nagubk82@gmail.com, linux-omap-open-source@linux.omap.com, dspgateway-devel-request@lists.sourceforge.net
List-Id: linux-omap@vger.kernel.org

>From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of ext
naga rajan
>Sent: Friday, June 30, 2006 1:49 PM
>Subject: DSPGateway problem with kernel2.6.14

>Warning: none of /sys/devices/platform/dsp.0/ifver,
>/sys/devices/platform/dsp0/i
>
>fver or /sys/devices/platform/dsp/ifver is
>found.
>(DSP Gateway driver is too old or not
>loaded)

http://dspgateway.sourceforge.net/pub/index.php?Page=3DFAQ#Q8

>open taskdev: No such file or directory

You didn't create task devices enough or at all.
ex_task.out will contain 12 tasks, so you need /dev/dsptask0 to 11 at
least.

BR,
Toshihiro Kobayashi
