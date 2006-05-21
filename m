From: Maximus <john.maximus@gmail.com>
Subject: dma request
Date: Sun, 21 May 2006 04:24:20 -0700
Message-ID: <3634de740605210424w207391f4v191462789a7dff59@mail.gmail.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
  i am trying to use omap-dma to dma some data from and to the device.

  In omap_set_dma_transfer_params ( ) - could anyone explain to me
what the arguments mean-
  could any one let me know what is
   1) frame count, element count, sync_mode

    what is the difference between element count and frame count?.

   how it is computed?.


   All i have is a buffer and some bytes to be transferred.


  there are other functions like -
   omap_set_dma_dest_params, omap_set_dma_src_params,
omap_set_dma_dest_data_pack,
 and so on

   could any one explain it what the arguments mean?



Regards,
j
