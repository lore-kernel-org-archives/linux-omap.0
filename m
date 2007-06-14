From: Ram <vshrirama@gmail.com>
Subject: camera mode in SDP
Date: Fri, 15 Jun 2007 02:26:52 +0530
Message-ID: <8bf247760706141356h275c6145sb03d9c3d60136e42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
  Im trying to write a sensor driver for omap2430 for a custom built board.

  I need a few clarifications regarding the camera port on OMAP2430SDP.

  OMAP 2430 supports both CCP and parallel mode.

  My sensor is connected parallelly to omap2430.

 Is ex3691 is connected in parallel mode or CCP mode on SDP?.


 Am referring to the linux 2.6.14 camera drivers. omap24xxcam.c.

According to the code,  The function sets omap24xxcam_cc_enable
sets it to the parallel mode.the comment to this function says a totally
different thing (CCP mode).

Most of us would prefer a generic way of choosing the type of
interface CCP/serially
so that we need to add sensor drivers if the sensor changes.

May be this is a nice feature to add in the next version of the drivers.


Thanks for your time.


please advice.


Regards,
sriram

Code fragment:

/* Set the value of the CC_CTRL register in cam->cc_ctrl that is required to
 * support the currently selected capture format in cam->pix.  The CC_CTRL bits
 * which must be configured are:  NOBT_SYNCHRO, BT_CORRECT, PAR_ORDERCAM,
 * PAR_CLK_POL, NOBT_HS_POL, NOBT_VS_POL, PAR_MODE, and CCP_MODE.  The CC_RST,
 * CC_FRAME_TRIG, and CC_EN bits are actively managed by the driver and should
 * be set to zero by this routine.
 */
static void
omap24xxcam_sensor_cc_ctrl(struct omap24xxcam_device *cam)
{
	struct v4l2_pix_format *pix = cam->still_capture?&cam->pix2:&cam->pix;
	struct camera_sensor *sensor = cam->cam_sensor;
	
	/* basic mode */
       /* Sets this to parallel mode (nothing to do which
sensor->parallel_mode) */
      /* bit0 = 0 is parallel and bit0 => 1 is serial */
	cam->cc_ctrl = sensor->parallel_mode << CC_CTRL_PAR_MODE_SHIFT;
	/* sync polarity */
	cam->cc_ctrl |= (sensor->hs_polarity << CC_CTRL_NOBT_HS_POL_SHIFT);
	cam->cc_ctrl |= (sensor->vs_polarity << CC_CTRL_NOBT_VS_POL_SHIFT);
	/* based on BT or NOBT */
	if ((sensor->parallel_mode == PAR_MODE_BT8) ||
	  (sensor->parallel_mode == PAR_MODE_BT10))
		/* BT correction enable */
		cam->cc_ctrl |= (sensor->bt_correction ? CC_CTRL_BT_CORRECT : 0);
	else
		/* always use the rising edger to trigger the acquisition
		   in NOBT modes. This is recommended */
		cam->cc_ctrl |= CC_CTRL_NOBT_SYNCHRO;

	switch (pix->pixelformat) {
	case V4L2_PIX_FMT_UYVY:
	case V4L2_PIX_FMT_RGB565:
	case V4L2_PIX_FMT_RGB555:
	default:
		/* These formats need a 16-bit byte swap */
		cam->cc_ctrl |= CC_CTRL_PAR_ORDERCAM;
	case V4L2_PIX_FMT_YUYV:
	case V4L2_PIX_FMT_RGB565X:
	case V4L2_PIX_FMT_RGB555X:
		/* These formats don't need a 16-bit byte swap */
		break;
	}
}
