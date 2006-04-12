From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Re: Is it possible to use NFS with built-in kernel on 5912 OSK?
Date: Wed, 12 Apr 2006 10:30:21 +0400
Message-ID: <9713be7f0604112330q3e868ae5qc6ee0ba3dd491c7@mail.gmail.com>
References: <9713be7f0604100643r394b2c5ct80caabf27c2225eb@mail.gmail.com>
	<443b0a9a.0a349ccc.352d.778b@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <443b0a9a.0a349ccc.352d.778b@mx.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > By the way, why OMAP5912 OSK has 32M of flash onboard, but the size of
> > default rootfs is only 16M?
> Because the rootfs' address starts from 0x1000000.


Can we somehow use (make fs and mount) previous 16M?
