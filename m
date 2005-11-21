From: "Sanjiv Malik" <sanjiv@faith.co.jp>
Subject: Sample source code to open the audio device through the kernel
	module
Date: Mon, 21 Nov 2005 16:28:28 +0900
Message-ID: <003401c5ee6d$2a9dae70$5a11a80a@smalik>
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

Hi friends,

Iam writing a kernel module thats open the audio device (/dev/dsp) =
through the Kernel module?=20
Currently iam using the sys_open(), sys_ioclt(),sys_write() functions to =
open, write and ioctl on the device... through the kernel module.
But iam not able to open the audio device.
So can anyone have the sample code for the same?

Thanks
Sanjiv
