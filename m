From: =?iso-8859-2?Q?Micha=B3_Szabat?= <michal611@interia.pl>
Subject: Re: [NFS problem][On osk_5912]
Date: Sat, 25 Mar 2006 13:39:53 +0100
Message-ID: <001401c65009$3d941340$0301a8c0@hydra>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello.
You shuld compile the kernel with options=20
CONFIG_NFS_FS=3Dy

CONFIG_NFS_V3=3Dy

CONFIG_ROOT_NFS=3Dy

You will need set some parameters for the kernel, for examlpe

# setenv bootargs console=3DttyS0,115200n8 noinitrd =
ip=3D${OSK_IP}:${PC_IP}:${GATEWAY_IP}:${NETMASK}:osk:eth0:off root=3D

/dev/nfs rw nfsroot=3D${PC_IP}:/data/rootfs2.6,nolock mem=3D32M

# saveenv

Check if server nfs work on ip 140.113.179.57, and if you can mount =
folder on this pc where is running server nfs.
