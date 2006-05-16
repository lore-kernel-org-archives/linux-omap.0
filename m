From: "Lucas Hartmann" <lucas.hartmann@gmail.com>
Subject: Writeable Replacement for /dev
Date: Tue, 16 May 2006 18:18:16 -0300
Message-ID: <2a3728820605161418v5a4a4e5cw24359c87cbba6fc6@mail.gmail.com>
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
To: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello.

I've been using kernel 2.6.12 with the /dev pseudo filesystem activated.
When i try to move to newer kernels, the /dev is no longer supported. This
causes the system to hang as the kernel tries to "open an initial console".

How do I set a writable tmpfs filesystem on the /dev? Is there any other
better way of doing this?

Using u-boot, loading kernel over tftp and root filesystem is on NFS.

Thanks.
--=20
Lucas Vinicius Hartmann
(83) 9967-4628

"There are 10 kinds of people in the world: The ones who understand binary
and the ones who don't."
