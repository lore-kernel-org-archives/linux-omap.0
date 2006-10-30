From: "Carlos, John J DA CIV USA ATC" <john.carlos@atc.army.mil>
Subject: aic23 audio on OSK5912
Date: Mon, 30 Oct 2006 14:22:47 -0500
Message-ID: <22CECCE071A8DC4CAB2412DC44CBEDF107A5A7AA@apgrb1atc-0058e.atc.army.mil>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux-Omap-Open-Source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello all,

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am using kernel 2.6.17.13 with =
omap2 patch applied.=A0 I compile
sound support and omap-audio-aic23 support.=A0 I get compile warning=20

"omap-audio-aic23 Section mismatch: reference to
.exit.text:omap_aic23_remove from .data between aic23_state (at offset =
0x24)
and input_stream"=20

And when I try to modprobe the module the system locks up.=A0 Is there =
a pacth
to fix this and does the aic23 driver work?

Thanks,
John
