From: "Komal Shah" <komal.shah802003@gmail.com>
Subject: sx1 alsa build failure
Date: Sun, 3 Dec 2006 23:43:48 +0530
Message-ID: <3a5b1be00612031013v14ca1789ge5c58d125733e675@mail.gmail.com>
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
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>, vovan888@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Vladimir Ananiev,

Could you please send a patch to fix this build error.?

sound/arm/omap/omap-alsa-sx1.c:32: error: `CN_IDX_SX1SND' undeclared
here (not in a function)
sound/arm/omap/omap-alsa-sx1.c:32: error: initializer element is not constant
sound/arm/omap/omap-alsa-sx1.c:32: error: (near initialization for
`cn_sx1snd_id.idx')
sound/arm/omap/omap-alsa-sx1.c:32: error: `CN_VAL_SX1SND' undeclared
here (not in a function)
sound/arm/omap/omap-alsa-sx1.c:32: error: initializer element is not constant
sound/arm/omap/omap-alsa-sx1.c:32: error: (near initialization for
`cn_sx1snd_id.val')


-- 
---Komal Shah
http://komalshah.blogspot.com
