From: "prafulla chandra vejendla" <v.prafulla@gmail.com>
Subject: SEGMENTATION FAULT while executing the application
Date: Wed, 15 Mar 2006 12:02:24 +0530
Message-ID: <26d3a31c0603142232w5cc33e36h8605881ad4466bd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,
Finally i built kernal and mounted the root file system through NFS for my
OSK5912 board.now i am trying to execute my application ,for that i placed
my application in NFS mount area .while execution it is giving error as
SEGMENTATION FAULT . the same application got executed verywell in the PC.
the exe has to create the output file and it has to place PCM samples in
that .but it is unable to create file .
what i found was, it is sending PCM samples to the stderr . after some time
it is giving as SEGMENTATION FAULT.
why is it so ?? where was the problem.can any one come accross this
problem??
thanks in advance
--prafulla chandra
