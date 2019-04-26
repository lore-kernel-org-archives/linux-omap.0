From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [RFC PATCH v3 net-next 03/11] net: ethernet: ti: cpsw: ale: add
 functions to modify VLANs/MDBs
Date: Fri, 26 Apr 2019 13:53:41 +0300
Message-ID: <20190426105341.GA22373@apalos>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-4-git-send-email-grygorii.strashko@ti.com>
 <20190426104156.GA2796@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190426104156.GA2796@khorivan>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>
List-Id: linux-omap@vger.kernel.org

Hi Ivan,

> >}
> >
> >+static int cpsw_ale_read_mc(struct cpsw_ale *ale, u8 *addr, int flags, u16 vid)
> See below.
> 
Yes
> >+{
> >+	u32 ale_entry[ALE_ENTRY_WORDS] = {0, 0, 0};
> >+	int idx;
> >+
> >+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
> >+	if (idx >= 0)
> >+		cpsw_ale_read(ale, idx, ale_entry);
> >+
> >+	return cpsw_ale_get_port_mask(ale_entry, ale->port_mask_bits);
> >+}
> >+
> >+int cpsw_ale_mcast_add_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
> >+			      int flags, u16 vid, int mcast_state)
> >+{
> >+	int mcast_members, ret;
> >+
> >+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) | port_mask;
> >+	ret = cpsw_ale_add_mcast(ale, addr, mcast_members, flags, vid,
> >+				 mcast_state);
> By fact, cpsw_ale_add_mcast() is doing modify itself already, just name is
> different.
> 
> These 3 func duplicate the existent functionality as result code is done twice.
> Better remove/combine them and rename existent ones, like:
> cpsw_ale_add_mcast() -> cpsw_ale_add_mcast_modify()
> cpsw_ale_del_mcast() -> cpsw_ale_del_mcast_modify()
> 
Yes this is correct. The reason the duplication exists is that this was
originally coded on top of the current cpsw code. So i didn't want to change any
part of the working driver. 
Since we are re-working a bunch of stuff now this makes sense

> >+
> >+	return ret;
> >+}
> >+
> >+int cpsw_ale_mcast_del_modify(struct cpsw_ale *ale, u8 *addr, int port_mask,
> >+			      int flags, u16 vid)
> See above.
and yes :)
> 
> >+{
> >+	int mcast_members, ret;
> >+	int idx;
> >+
> >+	mcast_members = cpsw_ale_read_mc(ale, addr, flags, vid) & ~port_mask;
> >+	idx = cpsw_ale_match_addr(ale, addr, (flags & ALE_VLAN) ? vid : 0);
> >+	if (idx < 0)
> >+		return 0;
> >+	ret = cpsw_ale_del_mcast(ale, addr, mcast_members, flags, vid);
> >+
> >+	return ret;
> >+}
> >+
 
Regards,
/Ilias
