From: "chandrasheakhar singh" <cp_singh@faith.co.jp>
Subject: Allocating user space memory inside LKM
Date: Wed, 7 Dec 2005 10:08:21 +0900
Message-ID: <009d01c5facb$7be7a190$4b13a80a@cpsingh>
Reply-To: chandrasheakhar singh <cp_singh@faith.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Dear all,

I'm working on a linux kernel 2.6.11 for h4 (OMAP 2420). I just want to =
get some memory
of user space inside kernel module. As when I'm sending PCM data to =
audio driver from kernel
module(KM) through audio_write (...) of driver API it gives  error as:

Audio: CopyFrom User failed.

In the 2.6.11 kernel  particularly for H4  target how to get some user =
space memory as=20
for this target this alloc_user_space() function is not available.

Any light on this issue will be great help.

Best Regards
chandrasheakhar


















=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
\    chandrashekhar singh
 \   cp_singh@faith.co.jp
 /   Faith Inc. Tokyo
/  www.faith.co.jp
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
