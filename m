From: "Louis Jung" <lhsj81@gmail.com>
Subject: Waitpid() issue
Date: Mon, 13 Mar 2006 11:57:02 +1100
Message-ID: <cb6819fd0603121657qe719cfco9ca94665fc549a76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi everyone,

I am currently working on the OMAP5910. I am using scratchbox for the
purpose of cross-compilation using glibc.
In my program there are few forking processes. However whenever I try to
wait for the child process to finish,
the wait( ) or waitpid( ) is ignored which leads to endless creation of
zombie processors. The cross-compiled binary works fine in the scratchbox,
the parent waits for the child as it is suppose to. The problem occurs only
when the binary is loaded onto the OMAP
platform (linux-2.6.12).

Currently I am using sigaction( ) with SA_NOCLDWAIT set instead of wait( )
function to get around this problem. However,
it would be great if I could find the source of the problem and fix that
instead of having to find an alternate solution.

>From my point of view the problem seems to be related with the
incompatibility of the glibc with the OMAP platform,
but with a great uncertainty. If anyone came across similar problem, feel
free to comment. I need all the advice and help
I can get.

Thank you very much for your support,
Regards,
Louis
