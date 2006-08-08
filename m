From: "LIMITED Nguyen Duong Thanh (CR/AEM Praktikant)" <DuongThanh.Nguyen@de.bosch.com>
Subject: AW: Write to file
Date: Tue, 8 Aug 2006 09:19:42 +0200
Message-ID: <B3FDBBC0428C8145A83F312B740CE67D075831@si-mail48.de.bosch.com>
References: <9713be7f0608070558g7be2c6c2hafdf0a76cd5298a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <9713be7f0608070558g7be2c6c2hafdf0a76cd5298a@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sergey Vointsev <vointsev@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

I have the same problem. I have a application write by C language, and i =
have to read and write files on system. But now I cross compiler it to =
run on OMAP5912, but it doesn't work anymore.=20

Can somebody tell me, that what can I do to read and write the files on =
the OMAP system, either I use the NFS or use the JFFS filesystems.=20

Very Thanks and have a nice day

Nguyen

P/S: sorry about my English.

-----Urspr=FCngliche Nachricht-----
Von: =
linux-omap-open-source-bounces+duongthanh.nguyen=3Dde.bosch.com@linux.oma=
p.com =
[mailto:linux-omap-open-source-bounces+duongthanh.nguyen=3Dde.bosch.com@l=
inux.omap.com] Im Auftrag von Sergey Vointsev
Gesendet: Montag, 7. August 2006 14:58
An: linux-omap-open-source@linux.omap.com
Betreff: Re: Write to file

Hi, Anant!

Why your application can't write the same directory where it is
located? You run application from NFS, right?
If you really need to remount root file system to RW, you can use the
following command
mount -n -o remount /

Sergey.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
