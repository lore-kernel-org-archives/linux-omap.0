From: "LIMITED Nguyen Duong Thanh (CR/AEM Praktikant)" <DuongThanh.Nguyen@de.bosch.com>
Subject: AW: CPU usage on OMAP5912
Date: Mon, 9 Oct 2006 11:51:20 +0200
Message-ID: <B3FDBBC0428C8145A83F312B740CE67D075878@si-mail48.de.bosch.com>
References: <4529EC27.5010200@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <4529EC27.5010200@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kai Svahn <kai.svahn@nokia.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I have tried "top" and "ps" on that(with Busybox 1.1.3), but is lack of =
option.
Is there anyway to crosscompile a "top" cmd with full option (like on =
PC) for the
OMAP5912 ?

And when I have tried this way, there are other problem that: I can't =
use a cmd like:

----------------------
>./myapplication &
>top >> statfile
----------------------

Do anyone know why dose the "&" not work? Do I must configure the =
Kernel?

Any help are precious,

Thanh Nguyen

P/S: sorry about my bad english


-----Urspr=FCngliche Nachricht-----
Von: =
linux-omap-open-source-bounces+duongthanh.nguyen=3Dde.bosch.com@linux.oma=
p.com =
[mailto:linux-omap-open-source-bounces+duongthanh.nguyen=3Dde.bosch.com@l=
inux.omap.com] Im Auftrag von Kai Svahn
Gesendet: Montag, 9. Oktober 2006 08:29
An: nduongthanh@yahoo.com
Cc: Linux-omap-open-source@linux.omap.com
Betreff: Re: CPU usage on OMAP5912

ext Duong Thanh Nguyen wrote:
> Hello everyone,
>
> I have a question, when i run a program on OMAP5912, kernel Linux. I =
want to know
> how much CPU percent and Memory of OMAP, that my program uses. I stuck =
at this point=20
> for a long time. Does anyone know how? Can i write a C function in my =
program to
> show these infomation
Why don't you use top? That shows a percentage of memory usage and cpu=20
usage.

Cheers,
Kai


_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
