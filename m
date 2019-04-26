From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH v3 net-next 03/11] net: ethernet: ti: cpsw: ale: add
 functions to modify VLANs/MDBs
Date: Fri, 26 Apr 2019 13:41:57 +0300
Message-ID: <20190426104156.GA2796@khorivan>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 25, 2019 at 01:24:19AM +0300, Grygorii Strashko wrote:
>From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
>A following patch introduces switchdev functionality. Add functions
>to cpsw ALE engine to modify VLANs/MDBs
>
>Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> drivers/net/ethernet/ti/cpsw_ale.c | 179 ++++++++++++++++++++++++++++-
> drivers/net/ethernet/ti/cpsw_ale.h |  10 ++
> 2 files changed, 187 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
>index d09768368dbd..add3f6e4917b 100644
>--- a/drivers/net/ethernet/ti/cpsw_ale.c
>+++ b/drivers/net/ethernet/ti/cpsw_ale.c
>@@ -400,6 +400,45 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
> 	return 0;
> }
>
>+static int cpsw_ale_read_mc(struct cpsw_ale *ale, u8 *addr, int flags, u16 vid)
See below.

>+{
>+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
>+	int idx;
>+
>+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
>+	if (idx >= 0)
>+		cpsw_ale_read(ale, idx, ale_entry);
>+
>+	return cpsw_ale_get_port_mask(ale_entry, ale->port_mask_bits);
>+}
>+
>+int cpsw_ale_mcast_add_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
>+			      int flags, u16 vid, int mcast_state)
>+{
>+	int mcast_members, ret;
>+
>+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) | port_mask;
>+	ret = cpsw_ale_add_mcast(ale, addr, mcast_members, flags, vid,
>+				 mcast_state);
By fact, cpsw_ale_add_mcast() is doing modify itself already, just name is
different.

These 3 func duplicate the existent functionality as result code is done twice.
Better remove/combine them and rename existent ones, like:
cpsw_ale_add_mcast() -> cpsw_ale_add_mcast_modify()
cpsw_ale_del_mcast() -> cpsw_ale_del_mcast_modify()

>+
>+	return ret;
>+}
>+
>+int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
>+			      int flags, u16 vid)
See above.

>+{
>+	int mcast_members, ret;
>+	int idx;
>+
>+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) & ~port_mask;
>+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
>+	if (idx < 0)
>+		return 0;
>+	ret = cpsw_ale_del_mcast(ale, addr, mcast_members, flags, vid);
>+
>+	return ret;
>+}
>+

[...]

-- 
Regards,
Ivan Khoronzhuk
