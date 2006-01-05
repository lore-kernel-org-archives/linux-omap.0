From: "Chen leonard-a17094" <liangchen@motorola.com>
Subject: Config Linux for omap embedded system
Date: Thu, 5 Jan 2006 09:58:42 +0800
Message-ID: <93481F4E3CC5F042BBDE9376E50F759A2A5A8B@zmy16exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi,=20

I'm a newbie for linux-omap, and am trying to port the linux-omap onto a
specific embedded system, which has 8M/8M rom/ram.

I have some questions regarding with configuring Linux:
1. how to config the total memory when making the kernel? For example,
8M/8M rom/ram.
2. how to specify the startup address when making the kernel? For
example, the kernel is expected to start from 0x0a000000.

3. how to let the linker allocate code/data/stack on specific addresses?
For example, code starts from 0x0a000000, data starts from 0x08000000,
and stack starts from 0x04000000.

Thanks in advance,
Liang=20
