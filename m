From: "Chetan Kapoor" <chetan.kapoor@flextronicssoftware.com>
Subject: Re: init (busybox) problem on OSK5912
Date: Wed, 10 May 2006 13:08:23 +0530
Message-ID: <14fc2db60605100038t7c95cd6ag18d2ee592ca1bbf@mail.gmail.com>
Reply-To: chetan.kapoor@flextronicssoftware.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,

I have made some findings to resolve this issue. May be this is helpful for=
 you.

We were also facing the similar issue where the gdbserver when linked
dynamically was always resulting in a segmentation fault. We have
ensured that the version of libraries used while compilation are same
in the target also. But still , the gdbserver was resulting in a crash
(always before accept system call).

After going through other mailing lists, I have found that this issue
is happening because of a bug in glibc libraries. I have rebuilt the
glibc libraries (2.3.5 version) for arm after deleting the
sysdeps/arm/memset.S file. I have used the newly built "libc.so.6" and
"ld-linux.so.2" for compilation and runtime environment. This time
gdbserver and other dynamically shared program worked fine.

May be you can give this step a try. I have followed the steps for
building toolchain from http://frank.harvard.edu/~coldwell/toolchain/

Regards,
Dinesh

++ Sent by Chetan Kapoor on behalf of Dinesh Arora ++

***********************  FSS-Unclassified   ***********************
