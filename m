From: Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Running linux on qemu omap
Date: Mon, 20 May 2019 21:05:33 +0200
Message-ID: <20190520190533.GA28160@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
To: linux-omap@vger.kernel.org, qemu-devel@nongnu.org
List-Id: linux-omap@vger.kernel.org

Hello

I am working on adding a maximum set of qemu machine on kernelCI.

For OMAP, five machine exists and I fail to boot any of them.
The maximum I can get with omap1_defconfig is
qemu-system-arm -kernel zImage -nographic -machine cheetah -append 'root=/dev/ram0 console=ttyO0'
Uncompressing Linux... done, booting the kernel.
then nothing more.

Does someone have a working config+version to share ?

Thanks
Regards
