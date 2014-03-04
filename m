From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v2 7/7] v4l: ti-vpe: Add selection API in VPE driver
Date: Tue, 04 Mar 2014 12:35:31 +0100
Message-ID: <5315BA83.5080500@xs4all.nl>
References: <1393832008-22174-1-git-send-email-archit@ti.com> <1393922965-15967-1-git-send-email-archit@ti.com> <1393922965-15967-8-git-send-email-archit@ti.com> <53159F7D.8020707@xs4all.nl> <5315B822.7010005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <5315B822.7010005@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: k.debski@samsung.com, linux-media@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/04/14 12:25, Archit Taneja wrote:
> I had a minor question about the selection API:
> 
> Are the V4L2_SET_TGT_CROP/COMPOSE_DEFAULT and the corresponding
> 'BOUNDS' targets supposed to be used with VIDIOC_S_SELECTION? If so,
> what's the expect behaviour?

No, those are read only in practice. So only used with G_SELECTION, never
with S_SELECTION.

Regards,

	Hans
