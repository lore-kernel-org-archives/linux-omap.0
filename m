From: "Abot Botbot" <dejanigma@hotmail.com>
Subject: NFS Bootargs
Date: Wed, 09 Aug 2006 14:26:36 +0000
Message-ID: <BAY102-F15BFC0DB6B83849C21C502A9550@phx.gbl>
References: <BAY102-F33964DA005C427B9694D64A9540@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <BAY102-F33964DA005C427B9694D64A9540@phx.gbl>
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

Hello all,


    I'm trying to boot off an NFS share as laid out in the OSK Users guid=
e=20
so I can begin my software development process. My buidling of the system=
=20
with the approrpiate makefiles has all gone seamlessly. I am attempting t=
o=20
boot from the NFS share on my linux machine, which I've demonstrated is=20
possible from a neighboring machine. The error is as follows:

Kernel panic: No init found.  Try passing init=3D option to kernel.

I have tried putting an "init=3D/bin/sh" argument into the bootargs strin=
g,=20
but that hasn't solved the problem. Does anyone else have a bootargs stri=
ng=20
for an NFS share that they have used succesfully? Here is the string I am=
=20
currently using for refference:

console=3DttyS0,115200n8 noinitrd rw ip=3Ddhcp root=3D/dev/nfs=20
nfsroot=3D192.168.1.101:/home/usr/projects/filesys,nolock mem=3D30M init=3D=
/bin/sh

Thanks for your help,
Andy

_________________________________________________________________
Don=92t just search. Find. Check out the new MSN Search!=20
http://search.msn.click-url.com/go/onm00200636ave/direct/01/
