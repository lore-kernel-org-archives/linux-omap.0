From: "jacky_wang" <jacky_wang@ovt.com.cn>
Subject: 2430 download problem
Date: Tue, 20 Nov 2007 15:51:22 -0800
Message-ID: <000f01c82bd0$41615970$0f01a8c0@jackywang>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
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

Hi:
    I am working on sdp2430-V4.0.1 development board. I'm using =
CSST_SDP2430_v1.4 download my uboot.bin. but whatever via UART or USB, =
It always occures "Failed to connect to target".I connect my serial =
cable from windows host to the uart port3(the one close to the LCD") and =
config the dip switches like this:
S4 : OFF  ,  OFF ,  OFF,  OFF,   ON ,   ON,   OFF,  OFF
S6 : ON   ,  OFF ,  OFF,  OFF,   OFF,   OFF,   OFF,  ON
S8 : ON   ,  ON   ,  ON   ,  ON   ,   ON ,   OFF,   ON,  OFF
S9 : ON   ,  OFF ,  ON   ,  OFF,   ON ,   ON,   ON,  OFF
S10 : ON,  ON   ,  ON   ,  ON   ,   --,      --,    --,     --

Does anyone encounter the same problem?  Any suggestions are welcome. 
