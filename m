From: "chetan.kapoor@flextronicssoftware.com" <chetan.kapoor@flextronicssoftware.com>
Subject: Re: init (busybox) problem on OSK5912
Date: Wed, 10 May 2006 03:21:49 -0400
Message-ID: <380-22006531072149281@M2W138.mail2web.com>
Reply-To: chetan.kapoor@flextronicssoftware.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

I have made some findings to resolve this issue=2E May be this is helpful =
for
you=2E

We were also facing the similar issue where the gdbserver when linked
dynamically was always resulting in a segmentation fault=2E We have ensure=
d
that the version of libraries used while compilation are same in the targe=
t
also=2E But still , the gdbserver was resulting in a crash (always before
accept system call)=2E=20

After going through other mailing lists, I have found that this issue is
happening because of a bug in glibc libraries=2E I have rebuilt the glibc
libraries (2=2E3=2E5 version) for arm after deleting the sysdeps/arm/memse=
t=2ES
file=2E I have used the newly built "libc=2Eso=2E6" and "ld-linux=2Eso=2E2=
" for
compilation and runtime environment=2E This time gdbserver and other
dynamically shared program worked fine=2E

May be you can give this step a try=2E I have followed the steps for build=
ing
toolchain from http://frank=2Eharvard=2Eedu/~coldwell/toolchain/

Regards,
Dinesh

++ Sent by Chetan Kapoor on behalf of Dinesh Arora ++

***********************  FSS-Unclassified   ***********************

--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web=2Ecom/ =2E
