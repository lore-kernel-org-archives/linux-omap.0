From: k c <omap_mails@hotmail.com>
Subject: OMAP2420 2.6.9 kernel + gettimeofday issue
Date: Wed, 21 Nov 2007 15:07:52 +0000
Message-ID: <BAY119-W25A72BD3B539AE822CD3A1F9780@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,
=20
  We are facing a strange issue. I am calling gettimeofday from my linux co=
de to do profiling. I am noticing that the seconds returned is double of wh=
at it should be. Can anyone let me know what could be the issue. This is on=
 OMAP2420 open source 2.6.9 kernel. I looked into do_gettimeofday implement=
ation in /arch/arm/kernel/time.c but haven't figured out the issue yet. Any=
 help will be much appreciated.
=20
Thanks,
KCR
_________________________________________________________________
Post free property ads on Yello Classifieds now! www.yello.in
http://ss1.richmedia.in/recurl.asp?pid=3D220=
